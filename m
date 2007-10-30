From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: cmipci CM_FLINKOFF disables multinchannel playback
Date: Tue, 30 Oct 2007 09:37:27 +0100
Message-ID: <1193733447.331.1218548909@webmail.messagingengine.com>
References: <4725EAB8.9070804@ipi.ac.ru>
	<1193675922.7613.1218416245@webmail.messagingengine.com>
	<472611F4.1040703@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5F78C246DE
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 09:37:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <472611F4.1040703@ipi.ac.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timofei V. Bondarenko wrote:
> No. I'm talking not about chip versions.
> 
> The definitions was changed in the cmipci driver code.
> In the patch named 'cmipci: update register definitions' about 18th 
> september.

Oops, that was an error.  Fixed now:
<http://hg.alsa-project.org/alsa-kernel/rev/bb3a8418635f>


Regards,
Clemens
