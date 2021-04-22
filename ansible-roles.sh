mkdir ansible
mv playbook.yaml ./ansible
mv inventory.yaml ./ansible
cd ansible
mkdir roles
cd roles
ansible-galaxy init docker
ansible-galaxy init jenkins
ansible-galaxy init nginx
echo "- name: install Docker
  hosts: docker
  become: yes
  tasks:
  - name: Install Docker Depencies
    apt:
      pkg:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg
      - lsb-release
      # - software-properties-common
      # - python3-pip
      # - git
      update_cache: true
  - name: Add Docker GPG Key
    apt_key:
      url: https://download.docker.com/linux/ubuntu/gpg
      state: present
  - name: Add Docker APT Repository
    apt_repository:
      repo: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ ansible_lsb.codename|lower }} stable
      state: present
  - name: Install the Docker Engine
    apt:
      pkg:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      update_cache: true
  - name: Add Ubuntu user to the docker group
    user:
      name: ubuntu
      groups: docker
      append: yes
  - name: Install docker-compose
    remote_user: ubuntu
    get_url: 
      url : https://github.com/docker/compose/releases/download/1.29.1-rc1/docker-compose-Linux-x86_64
      dest: /usr/local/bin/docker-compose
      mode: 'u+x,g+x'" > ./docker/tasks/main.yml

echo "- name: Install Jenkins
  hosts: jenkins
  become: true
  tasks:
    - name: Install Java
      apt:
        name: openjdk-8-jdk
        state: present
        update_cache: yes
    - name: Download Jenkins Key
      apt_key:
        url: https://pkg.jenkins.io/debian/jenkins.io.key
        state: present
    - name: Import Jenkins Repo
      apt_repository:
        repo: deb http://pkg.jenkins.io/debian-stable binary/
        state: present
    - name: Apt Install Jenkins 
      apt:
        name: jenkins
        state: present
        update_cache: yes
    - name: Start & Enable Jenkins
      systemd:
        name: jenkins
        state: started
        enabled: true
    - name: Sleep for 15 seconds and continue with play
      wait_for: timeout=15
    - name: ssh folder
      file:
        path: /home/jenkins/.ssh
        state: directory
        mode: "0700"
        owner: jenkins
        group: jenkins
    - name: install private key
      copy:
        src: ~/.ssh/ssh-aws-pc
        dest: /home/jenkins/.ssh/ssh-aws-pc
        owner: jenkins
        group: jenkins
        mode: u=rw,g=,o=
    - name: Get init password Jenkins
      shell: cat /var/lib/jenkins/secrets/initialAdminPassword
      changed_when: false
      register: result
    - name: Print init password Jenkins
      debug:
        var: result.stdout" > ./jenkins/tasks/main.yml

echo "events {}
http {
	server {
		listen 80;

		location / {
			proxy_pass http://frontend:5000/;
		}
	}
}
" > ./nginx/nginx.conf

echo "- name: 'download and install nginx using apt'
  apt:
    pkg:
    - nginx
    state: latest
    update_cache: true
- name: 'make sure that the nginx service is started'
  service:
    name: nginx
    state: started
- name: 'install the nginx.conf file on to the remote machine'
  template:
    src: nginx.conf
    dest: /etc/nginx/nginx.conf
  notify: 'reload nginx'" > ./nginx/tasks/main.yml

echo "- name: 'reload nginx'
  service:
    name: nginx
    state: reloaded" > ./nginx/handlers/main.yml

