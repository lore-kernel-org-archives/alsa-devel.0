From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 19:03:43 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020925020343.GC4779@porky>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org> <3D90FEF4.2040309@prism.gatech.edu> <20020925010013.GC990@porky> <3D911550.1000309@prism.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D911550.1000309@prism.gatech.edu>; from gte733z@prism.gatech.edu on Tue, Sep 24, 2002 at 18:45:52 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Weijia Yang <gte733z@prism.gatech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.09.24 18:45 Weijia Yang wrote:
> Thanks for the tip--everything compiles fine now.  Now, how exactly do I 
> go about testing these EGPIO settings? I see several EGPIO options in 
> alsamixer--do I just adjust these and find something that works? Thanks

    I suppose so. I just leave an MP3 playing in XMMS, and restart it after
making a change (though this isn't required for all changes; I'm just
cautious).
    I _think_ you modify each pin using the "EGPIO On/Off" to turn each pin
on and off, and select the different pins using "EGPIO select".
    When I have more time I will try to learn more about this, and may be
able to help more.

-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
