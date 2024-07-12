FROM jenkins/inbound-agent:latest

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip xvfb libxi6 libgconf-2-4 python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ChromeDriver
RUN wget -q https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip -O /tmp/chromedriver.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip

# Install Selenium and other Python packages
RUN pip3 install selenium imaplib2 beautifulsoup4 requests jenkinsapi

# Display the versions of Chrome and ChromeDriver
RUN google-chrome --version && chromedriver --version

USER jenkins
