import paramiko
import time

hostname = '10.0.2.17'  # Endereço IP da VM
username = 'root'  # Nome de usuário para a VM
password = '12345678'  # Senha para a VM
output_file = 'output.txt'  # Caminho do arquivo no host

# memoey
def monitor_memory():
    with open(output_file, 'a') as f:
        while True:
            try:
                client = paramiko.SSHClient()
                client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
                client.connect(hostname, username=username, password=password)

                stdin, stdout, stderr = client.exec_command('free -m')
                memory_info = stdout.read().decode()

                f.write(f"{time.strftime('%Y-%m-%d %H:%M:%S')}\n")
                f.write(memory_info)
                f.write("\n") 
                f.flush()

                client.close()
                time.sleep(5)
            except Exception as e:
                print(f"Erro conectar ou executar comando: {e}")
                time.sleep(5)
              
monitor_memory()
