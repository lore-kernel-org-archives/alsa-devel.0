From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: Guillemot Maxisound Support
Date: Thu, 15 May 2003 11:46:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC361F7.40902@student.kuleuven.ac.be>
References: <286558.1052850103221.JavaMail.nobody@daisy.psp.pas.earthlink.net> <5.2.0.9.2.20030515004237.00a96970@mail.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John F. Hubbard" <hubbardjohn@earthlink.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John F. Hubbard wrote:

> Pieter,
>
>     The Guillemot Maxisound looks like the perfect starter project for 
> an ALSA newcomer such as myself: complex, well-documented, yet 
> affordable.  (Thanks to everyone who recommended things to work on.  I 
> have had a grand time browsing through some great audio hardware.)

I agree on the topics complex & affordable, but the 'well-documented' 
statement isn't quite right. I had to figure out all about the card by 
reverse engineering & trial and error. Guillemot doesn't support us at all.

>
>     I would love to help with this thing.  I'll go get one, and begin 
> working with it.  An initial look at the CVS repository seems to show 
> that we do not yet have any SAM9707 code in there.  Please correct me 
> if I have missed it.

The code is not mature enough to be committed to CVS. So didn't ask for 
CVS inclusion yet, as I'm the only one working on it. Actually Uros 
Bizjak is also working on a SAM9407 driver, which I use & modify to 
support the ISIS architecture but the developement is suspended for now. 
The driver code I'm currently working on isn't 'release-level' code 
neither. It's main goal is to try and figure out how to get the card 
working. When I figure that one out, I'll do a complete rewrite.

I suggest you subscribe to the isisalsa-devel mailinglist 
(isisalsa-devel@lists.sourceforge.net) if you want to discuss the ISIS 
any further. I guess it will be considered noise on this list otherwise.

I'm stuck with a Master Thesis & final exams until end of june, so I 
won't be working on it until then

> thanks,
> john h 

thank you! I'm happy with every reinforcement.

Pieter






-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
