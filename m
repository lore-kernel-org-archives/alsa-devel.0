From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: Re: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 11:10:38 -0700 (PDT)
Message-ID: <654959.53327.qm@web50107.mail.re2.yahoo.com>
References: <20080801180059.GE11735@sirena.org.uk>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50107.mail.re2.yahoo.com (web50107.mail.re2.yahoo.com
	[206.190.38.35]) by alsa0.perex.cz (Postfix) with SMTP id 2A5591037EC
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 20:10:40 +0200 (CEST)
In-Reply-To: <20080801180059.GE11735@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org




--- On Fri, 1/8/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Subject: Re: [alsa-devel] WM9712 Not Giving output
> To: "Nitin Mahajan" <nitinm76@yahoo.com>
> Cc: alsa-devel@alsa-project.org
> Date: Friday, 1 August, 2008, 11:31 PM
> On Fri, Aug 01, 2008 at 10:27:24AM -0700, Nitin Mahajan
> wrote:
> 
> > If Master is not there, logically are the enough for
> playback?
> 
> > amixer set 'PCM' 255 unmute
> > amixer set 'Headphone' 255 unmute
> 
> No, you also need to ensure that the signal is routed from
> the DAC to
> the headphone output.

Ya Sure, I meant from Mixer settings point of view, are these settings enough?

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Send instant messages to your online friends http://uk.messenger.yahoo.com 
