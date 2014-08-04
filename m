From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 19/19] alsa: riptide: fix %d confusingly prefixed with
	0x in format strings
Date: Mon, 04 Aug 2014 09:20:58 +0200
Message-ID: <53DF345A.3000205@ladisch.de>
References: <1407111685-15351-1-git-send-email-hans@hanshq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407111685-15351-1-git-send-email-hans@hanshq.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Wennborg <hans@hanshq.net>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hans Wennborg wrote:
> Signed-off-by: Hans Wennborg <hans@hanshq.net>
> ---
>  sound/firewire/fireworks/fireworks_proc.c | 4 ++--
>  sound/pci/riptide/riptide.c               | 4 ++--

The fireworks patch got split.


Regards,
Clemens
