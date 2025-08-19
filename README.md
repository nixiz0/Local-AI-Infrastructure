# **Local AI Infrastructure Kit**

Innovative and powerful local AI infrastructure available offline without connection, independent, combining different innovative projects such as **OpenWebUI** for the application/Interface, **Ollama** for the server and local AI models and **Qdrant** for the powerful vector database.

---

## **Start the Stack**

Before starting the Stack, go to **config folder** and the **.env** file and config the *ports* you want and *[Ollama models you want to use](https://ollama.com/search)*

=> Click on **start.bat** if you are on Windows OR use the **start.sh** if you are on Mac / Linux

=> Or if you want to use docker commands :   
- **With GPU**:
  ```bash
  docker-compose -f docker-compose-gpu.yml -p <stack_name> up -d
  ```
- **With CPU**:
  ```bash
  docker-compose -f docker-compose-cpu.yml -p <stack_name> up -d
  ```

---

## **Configuration**

**Default Account Creation:**

Username = user777     
Email = user@openwebui.com   
Password = 1234   

**Default Advanced Configuration:**

Go on *admin panel* and go on *settings*

On *Documents* :    
- Change **Chunk size** to **1200** and **Overlap** to **150** 
- Enable the **Hybrid search**  
- On **Re-ranking model** put **jinaai/jina-reranker-v2-base-multilingual** to use a good re-ranking model  

On *Audio* :    
- Choose *Whisper* for the Speech to Text 
- On *Speech-to-Text Models* put **large** and then click on download button on the right  

---

## **Pull the Latest Images Before Starting (Recommended)**

To make sure you are using the latest versions of all images (for example, if any images have been updated), run the following commands **before** starting the stack:

- **With GPU**:
  ```bash
  docker-compose -f docker-compose-gpu.yml -p <stack_name> pull
  docker-compose -f docker-compose-gpu.yml -p <stack_name> up -d
  ```
- **With CPU**:
  ```bash
  docker-compose -f docker-compose-cpu.yml -p <stack_name> pull
  docker-compose -f docker-compose-cpu.yml -p <stack_name> up -d
  ```

This will download only the images that have changed, and keep unchanged images as is.

---

## Author

- [@nixiz0](https://github.com/nixiz0)