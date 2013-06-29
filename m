From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: adau1701: more direct regmap
	usage
Date: Sat, 29 Jun 2013 14:09:21 +0200
Message-ID: <51CECE71.70608@metafoo.de>
References: <1372363205-31244-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 914B8261A51
 for <alsa-devel@alsa-project.org>; Sat, 29 Jun 2013 14:05:50 +0200 (CEST)
In-Reply-To: <1372363205-31244-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/27/2013 10:00 PM, Daniel Mack wrote:
> Replace calls to snd_soc_update_bits() with regmap_update_bits().
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
