From: Russell Whitaker <russ@ashlandhome.net>
Subject: ca0106 broken (fwd)
Date: Thu, 21 Jan 2010 21:30:43 -0800 (PST)
Message-ID: <alpine.LNX.2.00.1001212122140.1655@bigred.russwhit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bigred.russwhit.org (unknown [66.241.84.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 00CC52448F
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 06:31:34 +0100 (CET)
Received: from bigred.russwhit.org (localhost [127.0.0.1])
	by bigred.russwhit.org (8.14.3/8.14.3) with ESMTP id o0M5UhQG001683
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 21:30:43 -0800
Received: from localhost (russ@localhost)
	by bigred.russwhit.org (8.14.3/8.14.3/Submit) with ESMTP id
	o0M5UhHh001679
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 21:30:43 -0800
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


Hi
Sent msg below and no responce.
As a work-around replaced ng code with know good code into 2.6.29.6
and it worked. Tried same trick with 2.6.31.12 and it won't compile.
If you send me something to try will do it and report back.
    Russ

---------- Forwarded message ----------
Date: Wed, 21 Oct 2009 14:54:45 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
To: James@superbug.demon.co.uk
Subject: ca0106 broken


Hi

ca0106 is known to work in these releases:
   linux-2.6.27.20
   linux-2.6.27.23
   linux-2.6.28.10

It is broken in:
   linux-2.6.29.6
   linux-2.6.30.9

For the broken releases dmesg reports:
   unknown hardware "CA0106"  ""  ""  ""  ""

Anything I can do to help?

   Russ
