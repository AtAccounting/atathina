# 🛠️ AT Athina — คู่มือบำรุงรักษาเว็บไซต์

> เอกสารนี้เก็บ **กุญแจ / รหัส / ขั้นตอน** ทั้งหมดที่จำเป็นสำหรับดูแลเว็บระยะยาว
> อัปเดต: 2026-03-28

---

## 🔑 ข้อมูลสำคัญ (กรอกหลังสมัครบัญชี)

| รายการ | ค่า | หมายเหตุ |
|--------|-----|---------|
| GitHub Username | `🔄 YOUR_USERNAME` | ชื่อบัญชี GitHub |
| GitHub Email | `🔄 YOUR_EMAIL` | อีเมลที่สมัคร |
| Repository Name | `atathina` | ชื่อ repo บน GitHub |
| URL เว็บ (GitHub Pages) | `🔄 https://YOUR_USERNAME.github.io/atathina` | URL จริง |
| URL สำรอง (Netlify) | `🔄 https://???.netlify.app` | ถ้าสมัคร Netlify ด้วย |
| Personal Access Token | เก็บใน **GitHub_Token.txt** แยก | ห้ามเก็บในไฟล์นี้ |
| GitHub Token Expiry | `🔄 วันหมดอายุ` | ต้องต่ออายุตามกำหนด |

> **🔴 Token** — เก็บแยกในไฟล์ที่ปลอดภัย ห้ามอัปโหลดขึ้น GitHub

---

## 🚀 การ Deploy (อัปเดตเว็บ)

### วิธีปกติ (ทำบ่อยที่สุด)
```
ดับเบิ้ลคลิก: deploy.bat
```
รอ 30 วินาที → เว็บอัปเดตอัตโนมัติ

### ครั้งแรก — Setup GitHub Pages
1. สมัครบัญชี GitHub ที่ github.com (ฟรี)
2. สร้าง Repository ใหม่ชื่อ `atathina` (Public)
3. รัน `deploy.bat` → กรอก Token ตอน Password
4. เปิด github.com/YOUR_USERNAME/atathina
5. ไปที่ **Settings → Pages**
6. Source: `Deploy from a branch`
7. Branch: `main` / `/ (root)` → Save
8. รอ 2-5 นาที → ได้ URL: `https://YOUR_USERNAME.github.io/atathina`

### สร้าง Personal Access Token (PAT)
```
1. เปิด: github.com → Settings (มุมบนขวา)
2. Developer settings → Personal access tokens → Tokens (classic)
3. Generate new token (classic)
4. Note: "AT Athina Website Deploy"
5. Expiration: No expiration (หรือ 1 year)
6. Scope: ✅ repo (ทั้งหมด)
7. Generate token → COPY ทันที (จะไม่แสดงอีก!)
8. เก็บใน: C:\Users\ntnsi\Documents\accounting_office_secret\GitHub_Token.txt
```

---

## 📁 โครงสร้างไฟล์เว็บ

```
website/
├── index.html          ← ไฟล์หลัก — แก้ที่นี่อย่างเดียว
├── sitemap.xml         ← อัปเดตวันที่หลังแก้เนื้อหา
├── robots.txt          ← ไม่ต้องแก้ (แก้ URL ครั้งเดียว)
├── netlify.toml        ← config deploy — ไม่ต้องแก้
├── deploy.bat          ← สคริปต์อัปโหลดขึ้น GitHub
├── .gitignore          ← ไฟล์ที่ไม่ upload
└── MAINTENANCE_GUIDE.md ← ไฟล์นี้ — คู่มือ
```

---

## ✏️ การแก้ไขเนื้อหา

### ค้นหาจุดที่ต้องเติมข้อมูลจริง
เปิด `index.html` แล้วค้นหา 🔄 (มีทั้งหมดประมาณ 20+ จุด)

| 🔄 จุดสำคัญ | ต้องใส่อะไร |
|------------|------------|
| `🔄 ที่อยู่สำนักงาน` | ที่อยู่จริง |
| `0X-XXXX-XXXX` | เบอร์โทรจริง |
| `@atathina` | LINE OA ID จริง |
| `X,XXX บาท/เดือน` | ราคาแพ็กเกจจริง |
| `ชื่อสมาชิกทีม A/B/C/D` | ชื่อจริง + ตำแหน่ง |
| `[ภาพ 1-5]` | รูปสำนักงาน/ทีมจริง |
| `atathina.com` | URL จริงหลัง deploy |

### ขั้นตอนแก้แล้ว deploy
```
1. เปิด index.html → แก้ข้อมูล
2. บันทึกไฟล์
3. ดับเบิ้ลคลิก deploy.bat
4. รอ 30 วินาที → เว็บอัปเดต
```

---

## 🌐 URL ทั้งหมด (Multi-Platform Backup)

| Platform | URL | Status |
|----------|-----|--------|
| GitHub Pages (หลัก) | `🔄 https://YOUR_USERNAME.github.io/atathina` | ⏳ รอ setup |
| Netlify (สำรอง 1) | `🔄 https://???.netlify.app` | ⏳ รอ setup |
| Google Business | `🔄 https://g.page/???` | ⏳ รอ setup |
| Facebook Page | `🔄 facebook.com/atathina` | ⏳ รอ setup |
| LINE OA | `🔄 line.me/ti/p/@atathina` | ⏳ รอ setup |

---

## 🔄 Checklist บำรุงรักษารายเดือน

- [ ] ตรวจสอบเว็บยังเปิดได้ปกติ
- [ ] ตรวจสอบ GitHub Token ยังไม่หมดอายุ
- [ ] อัปเดตเนื้อหา (ราคา / บริการใหม่ / รีวิวลูกค้า)
- [ ] อัปเดต `<lastmod>` ใน sitemap.xml
- [ ] ส่ง sitemap ใน Google Search Console (ครั้งแรก)

---

## 🆘 แก้ปัญหา

### เว็บไม่อัปเดตหลัง deploy
```
รอ 2-5 นาที แล้วกด Ctrl+F5 (force refresh)
หรือเปิดใน Incognito Mode
```

### Token หมดอายุ — push ไม่ได้
```
1. ไปที่ github.com → Settings → Developer settings
2. Personal access tokens → Generate new token
3. แก้ไฟล์ GitHub_Token.txt ด้วย token ใหม่
```

### แก้ URL ใน meta tags หลังได้ URL จริง
ค้นหา `atathina.com` ใน `index.html` และ `sitemap.xml` แล้วแทนที่ด้วย URL จริง
(มีทั้งหมดประมาณ 15 จุด — deploy.bat จะช่วยอัปโหลดให้อัตโนมัติ)

---

## 📊 SEO — สิ่งที่ทำไว้แล้ว

✅ Title tag — "AT Athina สำนักงานบัญชี — รับทำบัญชี จดทะเบียนบริษัท..."
✅ Meta description + keywords (30+ คำค้นหา)
✅ Open Graph tags (แชร์ใน Facebook/LINE สวยงาม)
✅ Twitter Card
✅ Schema.org AccountingService (Google เข้าใจธุรกิจ)
✅ sitemap.xml — 5 sections
✅ robots.txt — อนุญาต indexing ทั้งหมด
✅ Canonical URL
✅ Lang="th"

⏳ สิ่งที่ต้องทำเพิ่ม:
- ส่ง sitemap ใน Google Search Console
- สร้าง og-image.jpg (1200×630 px)
- ลง Google Business Profile

---

*คู่มือนี้อัปเดตครั้งสุดท้าย: 2026-03-28*
*ไฟล์ต้นฉบับ: `C:\Users\ntnsi\Documents\accounting_office_secret\website\`*
