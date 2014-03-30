From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Date: Sun, 30 Mar 2014 14:36:34 +0100
Message-ID: <53381DE2.9050907@codethink.co.uk>
References: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk> <20140329101043.GF21628@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140329101043.GF21628@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

On 29/03/14 10:10, Mark Brown wrote:
>>  sound/soc/sh/rcar/scu.c | 4 ++--

It was against your current development branch which is
what we having been testing against (due to the large number
of commits in the rcar area)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
