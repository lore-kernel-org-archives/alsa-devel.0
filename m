From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1 - try2] ASoC: add support for multiple
 cards/codecs in debugfs
Date: Thu, 1 Oct 2009 12:19:56 +0100
Message-ID: <20091001111956.GD19998@rakim.wolfsonmicro.main>
References: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
	<1254382367-27948-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091001105107.GB19998@rakim.wolfsonmicro.main>
	<200910011402.04406.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 528F31038F2
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 13:19:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910011402.04406.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 02:02:04PM +0300, Peter Ujfalusi wrote:

> > but this doesn't seem to accomplish that goal?  I can't actually spot
> > the difference either, I'm assuming it's just whitespace?  If so I'll
> > apply as-is.

> It is my editor, which removed the tailing space from that line, I have 
> mentioned it in the intro mail.

I've now applied the patch, except for this hunk which failed to apply
against for-2.6.33 so I dropped it.
