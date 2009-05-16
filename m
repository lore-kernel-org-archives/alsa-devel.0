From: "A.Haq Abbad" <haqman@gmail.com>
Subject: Another successful X-Fi driver test.
Date: Sat, 16 May 2009 20:25:54 +0100
Message-ID: <8de04f330905161225p519fa8bek5d718c469538b5c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id D4B7624667
	for <Alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 21:25:55 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4420928qyk.16
	for <Alsa-devel@alsa-project.org>; Sat, 16 May 2009 12:25:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here are some details:

System:
Intel Core 2 Duo E6600
Asus P5W DH Motherboard
X-Fi eXtreme Music
Intel HD audio onboard

Software:
Advanced Linux Sound Architecture Driver Version 1.0.20.
Compiled on May 16 2009 for kernel 2.6.28-11-generic (SMP).

Running Kubuntu 9.04, with default packages.

All major audio players tested and work fine.
Aduiocious does not work with 24bit mode as reported before.

System is stable, no issues encountered yet!

Recording through the mic works flawlessly.
Sound from speakers seem clear.
Switching between intel HD onboard audio and xfi
works fine, both enabled on the same system.

P.S
I installed the file alsa-driver-unstable-snapshot.tar.gz
now my alsa version is 1.0.20 instead of .18, does that
cause major issues? I thought the package will only install the
module snd-ctxfi, not the whole alsa! or is that not possible.

Let me know if you want me to run specific test.

Regards.
