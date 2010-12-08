From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: SAMSUNG: Fix initial return	value
Date: Wed, 8 Dec 2010 10:00:09 +0000
Message-ID: <20101208100009.GA22148@sirena.org.uk>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<20101203164225.GY859@rakim.wolfsonmicro.main>
	<AANLkTin8xrxvGTKe+X_B_FDQueUJ8DC8=vPvsxZH0B1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 877F42444E
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 11:00:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTin8xrxvGTKe+X_B_FDQueUJ8DC8=vPvsxZH0B1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Seungwhan Youn <sw.youn@samsung.com>, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 10:00:04AM +0900, Seungwhan Youn wrote:

> If there are something more needed to accept these 2 patches for
> 2.6.37, please let me know.

You'd need to at least resubmit against 2.6.37 but especially with the
second patch I'm not sure there's any urgency - the second patch is just
a minor code cleanup and has no practical effect.
