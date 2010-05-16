From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 2/6] openrd-client: initialise audio
Date: Sun, 16 May 2010 18:36:34 +0100
Message-ID: <20100516173626.GF9830@opensource.wolfsonmicro.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.041714493@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D33C24499
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 04:44:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100515153130.041714493@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, linux-arm-kernel@lists.infradead.org, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Sat, May 15, 2010 at 05:30:00PM +0200, apatard@mandriva.com wrote:
> This patch is reponsible for enabling audio on the openrd client board
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

This is OK by me and there's no cross-tree dependencies for the merge so
should go via the Orion tree I guess?  For what it's worth

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
