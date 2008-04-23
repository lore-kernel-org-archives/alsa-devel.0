From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/11] soc - ac97 - Clean up checkpatch
	warnings
Date: Wed, 23 Apr 2008 13:18:07 +0100
Message-ID: <20080423121800.GB28337@sirena.org.uk>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hve28dawc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7256F244EF
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:18:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hve28dawc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 23, 2008 at 02:16:19PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > +	if (codec == NULL)

> Actually, "if (!codec)" is a preferred form.

checkpatch doesn't complain about that :)
