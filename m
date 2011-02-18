From: Moustafa Chamli <moustafa.chamli@canonical.com>
Subject: USB audio devices & kernel panics
Date: Fri, 18 Feb 2011 09:35:10 -0500
Message-ID: <4D5E839E.6030500@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B94A924538
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 15:35:13 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1PqRQO-0005Oj-2R
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 14:35:12 +0000
Received: from [64.34.151.178] (helo=[10.153.108.157])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <moustafa.chamli@canonical.com>) id 1PqRQN-0004lh-Uk
	for alsa-devel@alsa-project.org; Fri, 18 Feb 2011 14:35:12 +0000
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

Hello,

I was told to ask at the alsa-dev list as to if there's a known bug and
fix with USB audio devices causing kernel panics.  A bug was reported on
Launchpad stating that it is fully reproducible:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/715318

Cheers
