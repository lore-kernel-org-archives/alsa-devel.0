From: Gregory Bonik <gregory@bonik.org>
Subject: Re: Implementing full-duplex realtime sound processor
Date: Mon, 23 Aug 2010 23:14:43 +0200
Message-ID: <1282598083.4691.26.camel@koffer>
References: <1282495236.8223.7.camel@koffer>
	<AANLkTimzWczB5XGN=16QaMDkd_mvW8bwK_14Bbpci+JL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C0E2445E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 23:14:56 +0200 (CEST)
Received: by wwb17 with SMTP id 17so706487wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 14:14:50 -0700 (PDT)
In-Reply-To: <AANLkTimzWczB5XGN=16QaMDkd_mvW8bwK_14Bbpci+JL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23/08/2010 10:50 +0100, James Courtier-Dutton wrote:
> Why don't you want to use JACK. It is a perfect fit for what you are
> trying to do, and it solves a LOT of problems that you don't yet know
> you will run into.

Just because I don't want to force the users to use JACK, since it's not
so standard. I plan to add support for it later, but I want my program
still be usable without it. What are the problems you are talking about?
