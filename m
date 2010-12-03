From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: Laying the groundwork
	for	compress_type overriding
Date: Fri, 3 Dec 2010 16:41:25 +0000
Message-ID: <20101203164124.GJ3182@sirena.org.uk>
References: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A8A6103B5E
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:41:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 02, 2010 at 02:53:00PM +0000, Dimitris Papastamos wrote:
> This patch series is to prepare ASoC for allowing the compress_type of the
> codec to be overriden by the machine driver.  Typically this will be done by
> providing an snd_soc_codec_conf struct which will contain the new compress_type
> in the machine driver.

Applied, thanks.
