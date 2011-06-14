From: ajay khandelwal <ajay.lforum@gmail.com>
Subject: IEC61937/SPDIF
Date: Tue, 14 Jun 2011 18:17:36 +0530
Message-ID: <BANLkTik_MxbjfXDu13=ajRoaOUucHT+HWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id E904224476
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 14:47:37 +0200 (CEST)
Received: by vws20 with SMTP id 20so4942024vws.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2011 05:47:36 -0700 (PDT)
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

Hi All,
 I have to develop driver for SPDIF output of my board connected to HDMI.

I'm not sure for following (specially IEC61937)
1) How should driver know if it is compressed audio or plain pcm
2) Is their any plugin available for IEC61937, I could see only for IEC958
3) Who should create burst preamble, some plug in or driver.

Thanks and Regards,
Ajay
