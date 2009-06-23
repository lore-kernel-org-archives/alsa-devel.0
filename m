From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: TWL4030: Fix voice interface
 clock masters
Date: Tue, 23 Jun 2009 10:52:51 +0100
Message-ID: <20090623095251.GB5422@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
	<200906220935.27903.peter.ujfalusi@nokia.com>
	<20090622102505.GA4730@sirena.org.uk>
	<200906231010.38207.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DE44D2463F
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 11:52:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906231010.38207.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, steve@sakoman.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2009 at 10:10:38AM +0300, Peter Ujfalusi wrote:

> Do you mean something like this:

Yes.

> It would be a honor...
> But before sending such a patch, I guess Steve Sakoman should give his 
> blessing to it (he is the original author of the twl4030 codec driver). Or 
> perhaps someone else also?

Steve is the only one I can really think of; looking at the effort
you've been putting into reviewing the driver I'd be surprised if he had
a problem.
