# Custom Windows GUI Preset

โปรเจคนี้คือชุดสคริปต์สำหรับติดตั้งโปรแกรม (ผ่าน `winget`) และปรับแต่ง Windows (Registry Tweaks) อัตโนมัติ โดยมีหน้าต่าง GUI สวยงาม (WPF) ให้ผู้ใช้สามารถเลือกติ๊กโปรแกรมที่ต้องการได้เอง 
เหมือนกับเครื่องมืออย่าง `winutil` ของ Chris Titus Tech แต่เป็นเวอร์ชันที่เราสามารถปรับแต่งเองได้ 100%

## ไฟล์ในโปรเจค
- `gui_preset.ps1`: ไฟล์สคริปต์หลักที่บรรจุโค้ดหน้าต่าง GUI (XAML) และคำสั่งติดตั้ง
- `run_local.bat`: ไฟล์สำหรับดับเบิ้ลคลิกเพื่อรันสคริปต์ทดสอบบนเครื่องตัวเอง (จะขอสิทธิ์ Admin อัตโนมัติ)

## วิธีนำไปใช้งานแบบออนไลน์ (irm <URL> | iex)
เมื่อคุณปรับแต่ง `gui_preset.ps1` จนพอใจแล้ว:
1. นำไฟล์ `gui_preset.ps1` ไปอัปโหลดขึ้น GitHub Repository ของคุณ (หรือ GitHub Gist)
2. กดเข้าไปที่ไฟล์ใน GitHub แล้วคลิกปุ่ม **Raw** 
3. คัดลอก URL นั้นมา (เช่น `https://raw.githubusercontent.com/username/repo/main/gui_preset.ps1`)
4. นำไปรันใน PowerShell (Run as Administrator) ที่เครื่องไหนก็ได้ ด้วยคำสั่ง:
   ```powershell
   irm https://raw.githubusercontent.com/username/repo/main/gui_preset.ps1 | iex
   ```

## วิธีเพิ่มโปรแกรมใหม่
เปิดไฟล์ `gui_preset.ps1` แล้ว:
1. เลื่อนไปที่ส่วน **XML/XAML** เพื่อเพิ่ม `<CheckBox>` ใหม่ในหมวดหมู่โปรแกรม
2. เลื่อนลงมาที่ส่วน **$appMap** เพื่อเพิ่มข้อมูลเชื่อมโยงระหว่าง CheckBox กับ `winget ID`
