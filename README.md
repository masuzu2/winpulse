# ⚡ WinPulse - Windows Setup & Optimizer PRO

**WinPulse** คือชุดสคริปต์สไตล์ `winutil` สำหรับติดตั้งโปรแกรม (ผ่าน `winget`) ปรับแต่งระบบ (Registry Tweaks) ลดปิง เพิ่มความลื่นไหล และลบไฟล์ขยะอัตโนมัติ โดยมีหน้าต่าง GUI สวยงาม (WPF) 

## 🚀 ฟีเจอร์หลัก (Key Features)
- **📦 Software Installer:** เลือกติดตั้ง Google Chrome, 7-Zip, VS Code, Git, Discord อัตโนมัติ
- **🌐 Network & Internet:** ปรับแต่ง TCP/IP แบบ Low Latency, เปลี่ยน DNS เป็น Cloudflare (1.1.1.1), ตั้งค่า MTU 1500
- **⚡ Reduce Input Lag:** ปรับ Win32Priority, ปิด Dynamic Tick เพื่อคีย์บอร์ดและเมาส์ที่ตอบสนองไวที่สุด
- **🔋 Ultimate Performance:** ปลดล็อกพลังงานสูงสุดของ CPU/GPU และปิด Power Throttling
- **🧠 Memory & Stutter Fix:** ปิดบีบอัดแรม (MMAgent) ลดอาการเกมสะดุด
- **🖱️ Classic Menu:** นำเมนูคลิกขวาแบบเก่าบน Windows 11 กลับมา
- **🛡️ Safety First:** มีระบบสร้าง System Restore Point อัตโนมัติก่อนเริ่มปรับแต่ง

## 💻 วิธีใช้งานแบบรวดเร็ว (Online Execution)
เปิด **PowerShell (Run as Administrator)** แล้วพิมพ์คำสั่ง:
```powershell
irm https://raw.githubusercontent.com/<username>/winpulse/main/gui_preset.ps1 | iex
```
*(หรือใช้ลิงก์ย่อของคุณเอง เช่น `irm dub.sh/winpulse | iex`)*

## 🛠️ วิธีรันบนเครื่องตัวเอง (Local Test)
ดับเบิ้ลคลิกไฟล์ `run_local.bat` ในโฟลเดอร์โปรเจคได้เลยครับ
