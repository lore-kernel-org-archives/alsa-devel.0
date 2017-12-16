From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 00/11] ASoC: fsl_ssi: Clean up - coding style level
Date: Fri, 15 Dec 2017 22:53:09 -0600
Message-ID: <19ce4850-5561-45b1-3c16-1dd5591ab88a@tabi.org>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 12/13/17 5:18 PM, Nicolin Chen wrote:
> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
> 
> So I am going to clean up the driver on both coding style level and
> program flow level.

I'm okay with everything except patch #3.
