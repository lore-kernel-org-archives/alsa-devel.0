From: Sebastian Krause <sebastian@realpath.org>
Subject: Re: no sound with hda-intel,
 conexant venice	chip	on hp 2836
Date: Thu, 30 Aug 2007 23:08:36 +0200
Message-ID: <46D731D4.4000504@realpath.org>
References: <20070815173601.GA3227@bentham.lan>	
	<1187227351.5512.280.camel@razman.gruemaster.com>	
	<874pizkzgx.fsf@news.realpath.org>	
	<1187313403.9720.48.camel@razman.gruemaster.com>	
	<87veazq2xi.fsf@news.realpath.org>
	<1188310959.31933.30.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id C20651037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 23:08:59 +0200 (CEST)
In-Reply-To: <1188310959.31933.30.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> My alc268 board has been commandeered for another project, but I should 
> be able to do more testing this week.
> Actually, Realtek posted several patches, and they are in the daily 
> snapshot here:  ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/
> 
> Try it out and see if it works better.  Your system isn't in the driver 
> specifically, but load it with the option "model=acer" and see if it works.

Thanks, that already works so far, now I have sound just normally :) I 
couldn't get the microphone to work yet, but I'll try out more later.

Sebastian
