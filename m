From: gsantosh@codeaurora.org
Subject: customized IOCTL in pcm platform driver.
Date: Mon, 8 Oct 2012 23:30:09 -0700 (PDT)
Message-ID: <d0ef8dd36b2e37d9f0f0886758cb5963.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 46E0E2615C0
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 08:30:25 +0200 (CEST)
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
Cc: tiwai@suse.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi All,

will ALSA framework provide any customized IOCTL functionality in PCM
platform driver.

in my  system there is a requirement to get some information from DSP to
user space and I am thinking to add IOCTL's, is there any method to
accommodate or how we can address this issue?

Regards,
Santosh
