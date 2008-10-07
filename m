From: "Jesslyn Abdul Salam" <jesslyn.abdulsalam@gmail.com>
Subject: AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 17:18:55 +0530
Message-ID: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id A7C0224544
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 13:49:09 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3225294wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 04:48:55 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for the past
few days. I got the driver patch from the linux-omap/alsa-devel mailing
lists. The driver got compiled along just fine. But when the kernel boots,
no sound cards have been listed.

Advanced Linux Sound Architecture Driver Version 1.0.17.

ASoC version
0.13.2
AIC23 Audio Codec
0.1
MCLK = 12000000 [12000000], usecount =
0
ALSA device
list:
    No soundcards
found.

Any one have tested this before ?


- Jesslyn Abdul Salam
