From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH 5/5] Echoaudio - add suspend/resume support
Date: Sun, 4 Apr 2010 12:25:27 +0200
Message-ID: <20100404122527.6730a94a@Jay>
References: <4BAF3303.9040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B4A952413A
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 12:26:22 +0200 (CEST)
In-Reply-To: <4BAF3303.9040201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Lupton <oliverlupton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Mar 2010 11:44:19 +0100
Oliver Lupton <oliverlupton@gmail.com> wrote:

> Just thought I'd mention that I've tested these five patches applied to 
> a fedora 12 2.6.32.9 kernel with an Indigo IO card and it appears to now 
> work fine when resuming from standby (which it didn't previously -- I 
> had to remove/reinsert the card and close all applications with the 
> device open)

Thanks for the report!


-- 
Giuliano.
