From: Nicholas Hall <ngh@grandcare.com>
Subject: EeeTop ET1611PUT pin issue?
Date: Tue, 30 Aug 2011 15:17:58 -0500
Message-ID: <CAM1Wdti0=Xd0QD-hLjabO0qu+NG5VrDsQi9bcw4zxAEJuJn=DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1953B1037F3
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 22:17:59 +0200 (CEST)
Received: by gxk1 with SMTP id 1so6173064gxk.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 13:17:59 -0700 (PDT)
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

Greetings,

Asus released a new line of EeeTop.  I get audio working fine out the rear
headphone jack.  Although the internal speakers output nothing.  I've been
doing research and it seems quite possible that the hardware is pinned out
unusually.  Does this seem like the case?

alsa-info
http://www.alsa-project.org/db/?f=cf43f9508ed2fde7792245f0f760dd76787a7776

My other thought was that the hardware is not reporting the state of the
headphone jack in use.  Are there any pointers on identifying and fixing
this issue?  I tried Asus phone support (LOL!, what a joke).  Do I need to
get in contact with an Asus engineer, or does the alsa-info output have
everything I need.  I must admit, a lot of the output is foreign to me.

Thanks in advanced!

-- 
Nicholas Hall
Software Developer
GrandCare Systems
