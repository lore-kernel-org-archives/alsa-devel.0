From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Mon, 29 Dec 2014 22:00:13 +0530
Message-ID: <CAK-LDb+KCWHz7A5im7cB=dQfCs8ioh2T+jsxk9PdAFHNSOuvzg@mail.gmail.com>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
 <CAK-LDb+i8ATb5GrA6=dx5Y6EZSct+A6epXwNdEoVN4797Yzmqw@mail.gmail.com>
 <20141229155357.GL17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 899782606F6
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 17:30:20 +0100 (CET)
Received: by mail-wi0-f174.google.com with SMTP id h11so22409094wiw.7
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 08:30:20 -0800 (PST)
In-Reply-To: <20141229155357.GL17800@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 29, 2014 at 9:23 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Dec 28, 2014 at 04:35:00PM +0530, Vaishali Thakkar wrote:
>> On Fri, Dec 26, 2014 at 10:14 AM, Vaishali Thakkar
>> <vthakkar1994@gmail.com> wrote:
>> > This patch introduces the use of function put_unaligned_be16.
>
>> Hello...Can someone please review my patch so that I can have idea
>> about I am on a right way or not??
>> I think this is missed by developers.
>
> You sent this on the 26th, two days later on the 28th you're demanding a
> review and complaining that we've missed this with a top posted quote.
> Even during a normal working period this would not be a reasnoable
> demand (a couple of weeks is normally a good *lower* limit, people have
> vacations and other things to do), and right now we're in the middle of
> the time of year when people from western societies typically take
> vacation.

I am really very sorry for this. Actually I am a newbie. I mainly
worked during opw-application period and there we used to work with
staging directory only. This is my first time, I am working with other
parts of kernel. So, I had kind of feeling that I might have done
something wrong that's why I am not getting any comments. But I think
its my fault. I may need to understand workflow of community properly
and I apologizes for that.

> This is not a good way to get people to pay attention, and since I don't
> want to create the impression that it works I'd not be expecting a quick
> response...

I agree. This is definitely not a good way and thanks for your reply.
I get to know about my mistake. I will be more careful next time.

Sorry Again

-- 
Vaishali
