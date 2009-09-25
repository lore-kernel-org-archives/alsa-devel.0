From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [PATCH] [ASOC] pxa-ssp increase
 max_channels to 8
Date: Fri, 25 Sep 2009 10:17:53 -0700
Message-ID: <20090925171752.GB4568@sirena.org.uk>
References: <1253881826-7954-1-git-send-email-dp@xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D651037F5
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 19:18:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253881826-7954-1-git-send-email-dp@xora.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Graeme Gregory <dp@xora.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 25, 2009 at 01:30:26PM +0100, Graeme Gregory wrote:
> When running in TDM mode there can be more than 2 channels used. Datasheet has
> figures for upto 8 channels so increase max_channels on all SSP interfaces to
> this figure.

> Signed-off-by: Graeme Gregory <dp@xora.org.uk>

Applied, thanks.
