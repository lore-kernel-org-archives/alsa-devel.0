From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Set up debugfs only once?per
 CODEC
Date: Fri, 13 Aug 2010 13:07:27 +0100
Message-ID: <20100813120727.GB21528@rakim.wolfsonmicro.main>
References: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201008130742.45006.peter.ujfalusi@nokia.com>
	<20100813090249.GA32249@sirena.org.uk>
	<201008131349.46624.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 115F524543
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 14:07:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008131349.46624.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 01:49:46PM +0300, Peter Ujfalusi wrote:
> On Friday 13 August 2010 12:02:49 ext Mark Brown wrote:

> > Meh, it's a debug facility and I hope it'll be sorted out within a week
> > or so anyway.

> Well, than it does not matter that much (the missing debugfs widget entries), 
> if you have plans for this.

Yes, I definitely want to deal with the root cause of the issue as well.
