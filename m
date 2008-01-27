From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: installation steps for us-122l tascam driver
Date: Sun, 27 Jan 2008 20:04:14 +0100
Message-ID: <200801272004.14287.fzu@wemgehoertderstaat.de>
References: <loom.20080127T142724-428@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E2711037EA
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 20:04:19 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so863820uge.50
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 11:04:18 -0800 (PST)
In-Reply-To: <loom.20080127T142724-428@post.gmane.org>
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
Cc: Xavier garabedian <xgarabedian@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Sonntag, 27. Januar 2008 schrieb Xavier garabedian:
> 
> i'm a linux beginner and i'm trying to make the us 122l work on ubuntu.
> i have seen the patches that you published, but i don't know the steps to
> install them and make the tascam work.

Um erm, blush..., I think the us122l patch is not yet "beginner digestible".
Put differently, please be patient some more weeks, I hope to put the patch
in a better shape then.
You might start learning alsa patch/build cycle with a stable driver, that's
already in linux kernel; then proceed learning the same for the jackd as
there isn't any alsa-pcm interface yet.

      Karsten
