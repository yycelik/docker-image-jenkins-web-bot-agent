FROM jenkins/inbound-agent:latest

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip xvfb libxi6 libgconf-2-4 python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install ChromeDriver
RUN wget -q https://storage.googleapis.com/chrome-for-testing-public/126.0.6478.126/linux64/chromedriver-linux64.zip -O /tmp/chromedriver.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip

# Create a virtual environment and install Selenium and other Python packages
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install selenium imaplib2 beautifulsoup4 requests jenkinsapi && \
	/opt/venv/bin/pip install --upgrade chromedriver-autoinstaller && \
    rm -rf /root/.cache

# Display the versions of Chrome and ChromeDriver
RUN google-chrome --version && chromedriver --version

# Ensure the virtual environment is used for the Jenkins user
ENV PATH="/opt/venv/bin:$PATH"

USER jenkins
