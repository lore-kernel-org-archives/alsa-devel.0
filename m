From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC/pxa-ssp.c: fix build on pxa2xx
Date: Mon, 27 Oct 2008 17:47:10 +0000
Message-ID: <20081027174710.GK5896@sirena.org.uk>
References: <1225129397.6519.49.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 681C12434E
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 18:47:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225129397.6519.49.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 27, 2008 at 03:43:17PM -0200, Daniel Ribeiro wrote:

> ASoC/pxa-ssp.c: fix build on pxa2xx
> 
> SSACDD and SSACD_SCDX8 dont exist on pxa2xx.
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

Thanks, will apply both.
