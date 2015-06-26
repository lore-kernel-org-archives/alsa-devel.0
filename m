From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
 After 2nd Run
Date: Fri, 26 Jun 2015 16:20:43 +0200
Message-ID: <20150626162043.afb6d3249ad665db99665d4f@ao2.it>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
 <55812940.5050906@ladisch.de> <1434531934.2471.9.camel@loki>
 <CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
 <5587B16A.90100@ti.com>
 <CA+k7WwZ2nW2T=YL59Ta98FGp751S6nv3d4rKU-qX5WGgdEmo0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp209.alice.it (smtp209.alice.it [82.57.200.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 98339265340
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 16:21:06 +0200 (CEST)
In-Reply-To: <CA+k7WwZ2nW2T=YL59Ta98FGp751S6nv3d4rKU-qX5WGgdEmo0Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Jun 2015 11:00:42 -0400
Azizul Hakim <azizulfahim2002@gmail.com> wrote:

> Yes, I tested with kernel 3.8.13 in both ubuntu and beaglebone.
>
> On Mon, Jun 22, 2015 at 2:55 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>
> wrote:
[...]
> > Are you running exactly the same kernel under ubuntu and debian?
[...]

Excuse me, Azizul, but in the thread you compare ubuntu and debian and
then here you say "ubuntu and beaglebone", do you mean:

  - Ubuntu on _PC_ and Debian on _beglebone_?

Maybe it's a silly question, but better be sure, because the
distribution should not make a huge difference when using the same
kernel, but the architecture does if it's a memory issue.

And please try to avoid top-posting :)

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
