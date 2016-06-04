From: Damien Zammit <damien.zammit@gmail.com>
Subject: usb-audio: four new quirks
Date: Sat, 4 Jun 2016 23:13:46 +1000
Message-ID: <5752D40A.6080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BC1D26145A
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 15:13:52 +0200 (CEST)
Received: by mail-pf0-f182.google.com with SMTP id f144so52624485pfa.3
 for <alsa-devel@alsa-project.org>; Sat, 04 Jun 2016 06:13:52 -0700 (PDT)
Received: from [192.168.140.2] (14-201-185-176.static.tpgi.com.au.
 [14.201.185.176])
 by smtp.googlemail.com with ESMTPSA id g13sm15525779pfk.2.2016.06.04.06.13.49
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Sat, 04 Jun 2016 06:13:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi folks,

I wrote these quirks, but they need to be tested on hardware, as I only
had the lsusb output from someone who had the devices.

- POD HD Pro quirk: http://pastebin.com/raw/TrPcYBGT
- POD X3 Pro quirk: http://pastebin.com/raw/DAEPuqvU
- Denon DN-X 1600 quirk: http://pastebin.com/raw/mpLUK01g
- Yamaha 01v96i quirk: http://pastebin.com/raw/Qb0er0vc

Regards,
Damien
