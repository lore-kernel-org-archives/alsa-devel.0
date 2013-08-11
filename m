From: Michael Jordan <mjordan1@catamount.wcu.edu> (by way of Michael Jordan
 <jordan.mymail@gmail.com>)
Subject: Hello
Date: Sun, 11 Aug 2013 15:37:16 -0400
Message-ID: <20130811153716.0cebf7d3@mach1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B109A2608CF
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 21:39:10 +0200 (CEST)
Received: by mail-qc0-f174.google.com with SMTP id c1so3019633qcz.19
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 12:39:09 -0700 (PDT)
Received: from mach1 ([24.246.150.10])
 by mx.google.com with ESMTPSA id h4sm33447889qai.6.2013.08.11.12.39.08
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Sun, 11 Aug 2013 12:39:09 -0700 (PDT)
Resent-Message-ID: <20130811153906.384ad23e@mach1>
Resent-To: <alsa-devel@alsa-project.org>
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

Hello all,

I am involved in a university project using a TI OMAPL138 EXPKIT
(Logic PD Zoom Board) to create a sound processing box. I am tasked with
developing the code to replace the TLV320AIC3106 with a PCM3168A due to
the greater ADC/DAC count. We have already accomplished the hardware
end, and I have been exercising my linux skills at trying
to put this together. I found this list and subscribed, and I am glad I
sat and listened for a bit before I said anything. 457 patches in the
last 10 days! My fingers would fall off!

I will get together what I have been working on (2 files
pcm3168a.c and pcm3168a.h) and post them. I have some questions,
obviously, but I will follow up with them in a bit. If someone could
help me along it would be greatly appreciated. Or if I can just provide
some relevant information, I would be happy to do that as well.

Thanks,

Michael
