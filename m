From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Convert HF and HS
	drivers	to use DAPM OUT_DRV widget
Date: Mon, 20 Dec 2010 16:44:01 +0000
Message-ID: <20101220164401.GD14986@sirena.org.uk>
References: <1889FA7136B567478A67D4B0F85B0CCEA4F6D2E0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 639461038EA
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 17:44:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4F6D2E0@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 10:39:20AM -0600, Olaya, Margarita wrote:
> Make the phoenix HS and HF drivers use the new DAPM driver
> widget in order to guarantee power ON/OFF order sequence.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
