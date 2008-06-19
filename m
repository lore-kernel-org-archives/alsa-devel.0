From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa: add annotations to bitwise type
 snd_pcm_hw_param_t
Date: Thu, 19 Jun 2008 10:34:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806191034020.1798@tm8103-a.perex-int.cz>
References: <1213821913.2125.21.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BF11103801
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 10:34:37 +0200 (CEST)
In-Reply-To: <1213821913.2125.21.camel@brick>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: alsa-devel@alsa-project.org, Alexander Viro <viro@ftp.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Jun 2008, Harvey Harrison wrote:

> Fully half of all alsa sparse warnings are from snd_pcm_hw_param_t degrading
> to integer type, this goes a long way towards eliminating them.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Applied to ALSA repo. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
