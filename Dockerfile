FROM jenkins/inbound-agent:latest

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip xvfb libxi6 libgconf-2-4 python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ######################################################
# https://googlechromelabs.github.io/chrome-for-testing/
# ######################################################

# Install Google Chrome
RUN wget -q -O /tmp/chrome-linux64.zip https://storage.googleapis.com/chrome-for-testing-public/131.0.6778.85/linux64/chrome-linux64.zip && \
    unzip /tmp/chrome-linux64.zip -d /opt/ && \
    mv /opt/chrome-linux64 /opt/google-chrome && \
    ln -s /opt/google-chrome/chrome /usr/local/bin/google-chrome && \
    chmod +x /usr/local/bin/google-chrome && \
    rm /tmp/chrome-linux64.zip

# Install ChromeDriver
RUN wget -q -O /tmp/chromedriver-linux64.zip https://storage.googleapis.com/chrome-for-testing-public/131.0.6778.85/linux64/chromedriver-linux64.zip && \
    unzip /tmp/chromedriver-linux64.zip -d /opt/ && \
    mv /opt/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf /tmp/chromedriver-linux64.zip /opt/chromedriver-linux64

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
