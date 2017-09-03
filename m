From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Raspberry PI reports no channels, period and buffer
Date: Sun, 3 Sep 2017 15:32:54 +0200
Message-ID: <51497866-2df0-c107-7fee-c54b7e2d8626@ladisch.de>
References: <7b5bd5bb-8394-432f-dfa8-d55cac3d52c7@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5C3266CE1
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 15:33:46 +0200 (CEST)
Received: from [192.168.42.101] (tmo-096-206.customers.d1-online.com
 [80.187.96.206])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 38D9355811BE
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 15:33:46 +0200 (CEST)
In-Reply-To: <7b5bd5bb-8394-432f-dfa8-d55cac3d52c7@jikos.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Petr Kulhavy wrote:
> I'm writing an audio decoding program for ALSA, which among others detects audio capabilities.
> It uses the snd_pcm_hw_params_get_XXX() functions for that.

How did you get the hw_params?


Regards,
Clemens
