From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: S3C2412: suspend and resume support
Date: Thu, 22 Nov 2007 13:10:22 +0000
Message-ID: <20071122131021.GB5494@sirena.org.uk>
References: <20071120123334.GA27701@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D81D24567
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 11:17:59 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>) id 1IvVbj-0006QH-3K
	for alsa-devel@alsa-project.org; Fri, 23 Nov 2007 10:17:59 +0000
Resent-Message-ID: <20071123101759.GB22760@sirena.org.uk>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <20071120123334.GA27701@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Liam Girwood <liam.girdwood@opensource.wolfsonmicro.com>, ALSA Devel List <alsa-devel@alsa-project.org>, Vincent Sanders <vince@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 12:33:34PM +0000, Ben Dooks wrote:
> Support for suspend/resume for the S3C2412 ASoC IIS
> core driver.

> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Looks good minus the whitespace change Jan-Benedict pointed out.  I've
removed that and applied to linux-2.6-asoc - thanks!

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
