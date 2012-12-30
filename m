From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdsp rpm support
Date: Sun, 30 Dec 2012 13:09:13 +0100
Message-ID: <50E02EE9.3040809@drcomp.erfurt.thur.de>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org> <1326884040.18308.6.camel@yoyo4>
 <4F3926E3.1050809@drcomp.erfurt.thur.de> <1337260874.2077.6.camel@yoyo5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 15964261714
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2012 13:20:03 +0100 (CET)
In-Reply-To: <1337260874.2077.6.camel@yoyo5>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Haefeli <reduzent@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/17/12 15:21, Roman Haefeli wrote:

> Hi Adrian

Hi!

> In the meantime I upgraded my machine to Ubuntu 12.04 which comes with
> Linux 3.2.0 and alsa 1.0.25. The symptoms are still the same. When I
> insert the cardbus adapter and load the snd-hdsp module, I get this in
> dmesg:

JFTR: Karl Grill has recently provided a patch that fixes the RPM detection.

I've tested his patch and will submit it within the next two weeks (I'm
currently on vacation).

So you might want to check Takashi's tree in mid January or dig up
Karl's patch from this list.


Cheers
