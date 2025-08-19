# **Local AI Infrastructure Kit**

**OpenWebUI Account Creation:**

Username = user777     
Email = user@openwebui.com   
Password = 1234   

---

## **Start the Stack**

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