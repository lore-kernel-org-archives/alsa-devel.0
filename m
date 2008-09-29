From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/5] [RFC] ALSA ASOC adds destination and
	source port for dma
Date: Mon, 29 Sep 2008 14:26:58 +0100
Message-ID: <20080929132656.GH27647@sirena.org.uk>
References: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 48C042435B
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 15:26:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2008 at 03:23:52PM +0530, Arun KS wrote:

> @@ -147,12 +148,14 @@ static int omap_pcm_prepare(struct
> snd_pcm_substream *substream)

Your MUA appears to have word wrapped and therefore corrupted this
patch (and may well have done the same thing with the others).  You
might want to look into using something like git send-email to generate
your patches if you can't see how to fix this with the client you are
using.
