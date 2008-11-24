From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: CVS, git, or something else? Build patch failure.
Date: Mon, 24 Nov 2008 23:56:52 +0000
Message-ID: <200811242356.52786.maillist@superlative.org>
References: <200811242310.29792.maillist@superlative.org>
	<200811251247.27296.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from virtuser.com (unknown [77.92.93.3])
	by alsa0.perex.cz (Postfix) with ESMTP id C97B824410
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 00:56:55 +0100 (CET)
Received: from [82.152.152.239] (helo=asmodeus.superlative.org)
	by apollo.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1L4lIT-0006Ww-K5
	for alsa-devel@alsa-project.org; Mon, 24 Nov 2008 23:56:53 +0000
In-Reply-To: <200811251247.27296.linux@audioscience.com>
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

On Monday 24 November 2008 23:47:27 Eliot Blennerhassett wrote:

>
> I see this too. My kernel: ubuntu 2.6.24-21-generic

I'm on Mandriva kernel version 2.6.24.7

>
> No. git is right.

Thank you very much for confirming this. I thought I was missing something, 
but I couldn't see what.

I believe the kernerl version shouldn't matter as this error occurs when 
trying to apply a patch to one of the main files. I guess we have to sit 
tight for someone to fix this, or just delete and ignore the patch file for 
now?

Cheers,

-- 
Keith A. Milner
