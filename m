From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 2.6.30] ASoC: improve I2C	initialization
	code in CS4270 driver
Date: Fri, 23 Jan 2009 22:59:09 +0000
Message-ID: <20090123225908.GA2340@sirena.org.uk>
References: <1232749879-27691-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D88391038FE
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 23:59:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1232749879-27691-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2009 at 04:31:19PM -0600, Timur Tabi wrote:
> Further improvements in the I2C initialization sequence of the CS4270 driver.
> All ASoC initialization is now done in the I2C probe function.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.
