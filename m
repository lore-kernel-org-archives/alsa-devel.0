From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: [Alsa-user] [PATCH] emu10k1 multichannel	support
Date: Sat, 22 Jan 2005 00:49:05 +0000
Message-ID: <41F1A301.6040609@superbug.co.uk>
References: <1106091073.24484.60.camel@krustophenia.net>	 <20050119195154.GR27550@samad.com.au>	 <1106169110.3050.9.camel@krustophenia.net>	 <20050119221903.GD14030@samad.com.au> <1106343708.3232.45.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106343708.3232.45.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alexander Samad <alex@samad.com.au>, alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Thu, 2005-01-20 at 09:19 +1100, Alexander Samad wrote:
> 
>>Hi
>>
>>Sorry to bug you, but I used aplay -v on plughw0,3 and I saw that I
>>have the 16 channels, I think the problem is I can't move it into
>>digital output ????
>>
>>
>>plus how do I set it to 96Khz not 48 ???
>>
> 
> 
> Actually there is an experimental patch for 24 bit and 96/192 support on
> this card.  It probably conflicts with my patch.
> 
> http://www.alsa-project.org/~james/alsa-driver/p16v/
> 
> I would like to hear whether this works for you.
> 
> Lee
> 

WARNING: The p16v patch does not have any volume control yet. So, turn 
those speakers right down first!!!



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
