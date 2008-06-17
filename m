From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: git-http interface to ALSA git repositories?
Date: Tue, 17 Jun 2008 14:27:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806171426480.1798@tm8103-a.perex-int.cz>
References: <485295CF.2080802@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 60629243BF
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 14:27:41 +0200 (CEST)
In-Reply-To: <485295CF.2080802@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Jun 2008, Timur Tabi wrote:

> My company's firewall blocks the git protocol, so I need to use http:// 
> to clone git repositories.  What is the http path for the ALSA git 
> repository?

I updated web server configuration, so the HTTP access is available here:

    http://git.alsa-project.org/http/alsa-driver.git 
    http://git.alsa-project.org/http/alsa-kernel.git 
    http://git.alsa-project.org/http/alsa-kmirror.git 

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
