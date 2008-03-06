From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aplay error - cant resolve symbol alsa_lisp_init
Date: Thu, 06 Mar 2008 11:26:30 +0100
Message-ID: <47CFC6D6.5030305@ladisch.de>
References: <61445c750803050927r77212b12qe12a2f45615282c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2BA641038F5
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 11:24:59 +0100 (CET)
In-Reply-To: <61445c750803050927r77212b12qe12a2f45615282c4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> Dec 31 16:04:42 kernel: Error -5 while decompressing!

I'd guess you're using a compressed ROM FS which is corrupted.


HTH
Clemens
