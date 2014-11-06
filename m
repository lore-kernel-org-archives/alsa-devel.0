From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: tfa9879: Add bass and treble gain/freq
 controls.
Date: Thu, 06 Nov 2014 14:17:11 +0100
Message-ID: <545B74D7.4060400@metafoo.de>
References: <1415278441-27866-1-git-send-email-peda@lysator.liu.se> <1415278441-27866-3-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415278441-27866-3-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/06/2014 01:54 PM, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>   sound/soc/codecs/tfa9879.c |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Is there any specific reason why this is separate and not part of the 
initial patch?
