From: chris@idlelion.net
Subject: Next steps
Date: Tue, 29 May 2007 09:55:22 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0705290952230.2627@tick.idlelion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alnrmhc11.comcast.net (alnrmhc11.comcast.net [206.18.177.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D813243A0
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 16:55:36 +0200 (CEST)
Received: from localhost (tick.idlelion.net [127.0.0.1])
	by tick.idlelion.net (8.13.8/8.13.4) with ESMTP id l4TEtMNi002768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 09:55:22 -0500
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

Hey gang,

I'm trying to work on issue 305, suspend/resume for cs46xx.

I'm running CentOS 5, so I'd like to work on what's current for that 
distribution first, and patch to latest if needed after that.

I think I have the correct source package, but the only mention of cs46xx 
I could find in the source is a configuration file. Running make doesn't 
make the cs46xx module, AFAICT.

Which source (package)(s) should I have?

How do I track down the source file(s) I need to examine?

Thanks,
Chris
