From: Manuel Jander <manuel.jander@gmail.com>
Subject: Patch for au88x0 driver. Fix audacious issue and add
	auto reset in case of hardware ADB ctrl failure.
Date: Thu, 3 Sep 2009 22:10:31 +0200
Message-ID: <21ed1c370909031310i8c899fbw919b033315e15af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 8597724415
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 22:10:32 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so1096381fga.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 13:10:32 -0700 (PDT)
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

Hi,

does anybody still have a AU88x0 card ? I know they are quite ancient
now, but if anyone could give the attached patch a try ? Would be
nice.
I made the patch against linux-2.6.30.4
http://micro.homelinux.net/~mjander/au88x0.diff.gz

Best Regards,
Manuel
